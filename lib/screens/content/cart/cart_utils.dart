import 'package:flutterbase/constants.dart';
import 'package:flutterbase/enums/enums.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/models.dart';

class CartItemUtils {
  CartItemUtils(this.item) {
    if (amountFromBill()) {
      var amount = double.parse(
        item.bill?.nettCalculations?.due.toString() ?? '0',
      );

      if (item.amount != amount) {
        item.amount = amount;

        flagCartItemError = true;
      }
    }
  }

  CartItem item;
  bool flagCartItemError = false;

  List<MatrixItemGroup> syncItems(
    List<MatrixItemGroup> remote,
    List<MatrixItemGroup> local,
  ) {
    var items = remote;
    var citems = local;

    try {
      for (var ii = 0; ii < items.length; ii++) {
        var item = items[ii];
        var citem = citems[ii];

        var hasDailyQuota = (item.hasDailyQuota ?? false);
        var gotQuotaForToday = ((item.remainingDailyQuota ?? 0) > 0);
        var canUpdateQuantities = !(hasDailyQuota && !gotQuotaForToday);

        var subitems = item.subitems;
        var csubitems = citem.subitems;

        if (!canUpdateQuantities) {
          flagCartItemError = true;
          continue;
        }

        if (subitems.isEmpty) {
          continue;
        }

        if (csubitems.isEmpty) {
          continue;
        }

        for (var iis = 0; iis < items.length; iis++) {
          var item = items[iis];
          var citem = citems[iis];

          var subitems = item.subitems;
          var csubitems = citem.subitems;

          if (subitems.isEmpty) {
            continue;
          }

          if (csubitems.isEmpty) {
            continue;
          }

          for (var isi = 0; isi < subitems.length; isi++) {
            var subitem = subitems[isi];
            var csubitem = csubitems[isi];

            var quantities = subitem.quantities;
            var cquantities = csubitem.quantities;

            if (quantities.isEmpty) {
              continue;
            }

            if (cquantities.isEmpty) {
              continue;
            }

            for (var iisq = 0; iisq < quantities.length; iisq++) {
              var matrix = quantities[iisq];
              var cmatrix = cquantities[iisq];

              var maxStock = matrix.remainingStock ?? 0;
              var hasStockTracking = matrix.hasStockTracking ?? false;

              if (matrix.id == cmatrix.id) {
                matrix.amount = cmatrix.amount;
              }

              // for bill type 4
              if (editableMatrixRate()) {
                matrix.rate.value = cmatrix.rate.value;
                matrix.amount = 1; // enforce 1 qty
              }

              if (hasStockTracking && cmatrix.amount > maxStock) {
                matrix.amount = maxStock;

                xlog(
                  'stock tracking enabled. remaining stock reduced lower than current. override then.',
                );
                flagCartItemError = true;
              }
            }
          }
        }
      }
    } catch (e) {
      xdd(e);
      xlog('[CartUtils.syncItems] error.');
      flagCartItemError = true;
    }

    return remote;
  }

  List<MatrixExtraField> syncExtraFields(
    List<MatrixExtraField> remote,
    List<MatrixExtraField> local,
  ) {
    var merge = List<MatrixExtraField>.from(remote);

    try {
      for (var i = 0; i < merge.length; i++) {
        var extraField = merge[i];
        var cextraField = local[i];

        if (extraField.type != cextraField.type) {
          xlog('extra field type. use remote');
          flagCartItemError = true;
          continue;
        }

        extraField.value = cextraField.value;
      }
    } catch (e) {
      xdd(e);
      xlog('[CartUtils.syncExtraFields] error.');
      flagCartItemError = true;
    }

    return merge;
  }

  Future<void> syncRemoteDetails(List<CartMatrix> remote) async {
    flagCartItemError = false;

    var merge = List<CartMatrix>.from(remote);
    var cdetails = item.details ?? [];

    try {
      for (var g = 0; g < merge.length; g++) {
        var group = merge[g];
        var cgroup = cdetails[g];

        if (group.items != null) {
          var items = group.items ?? [];
          var citems = cgroup.items ?? [];

          group.items = syncItems(items, citems);

          continue;
        }

        if (group.extraFields != null) {
          var extraFields = group.extraFields ?? [];
          var cextraFields = cgroup.extraFields ?? [];

          group.extraFields = syncExtraFields(extraFields, cextraFields);

          continue;
        }
      }
    } catch (e) {
      xlog(
        '[CartUtils.syncRemoteDetails] error for #${item.id}. use remote matrix.',
      );
      flagCartItemError = true;
    }

    item.details = merge;
  }

  bool emptyDetails() {
    return (item.details ?? []).length == 0;
  }

  String getTitle() {
    // return "${item.bill?.referenceNumber} - ${item.bill?.description}";
    return getServiceName();
  }

  double getAmount() {
    return item.amount;
  }

  void setAmount(double amount) {
    item.amount = amount;
  }

  String getBillNumber() {
    return item.bill?.billNumber ?? '';
  }

  String getChargeTo() {
    if (hasService()) {
      return item.service?.chargedTo ?? '';
    }

    if (hasBill()) {
      return item.bill?.service?.chargedTo ?? '';
    }

    return '';
  }

  String getServiceRefNumber() {
    if (hasBill()) {
      return item.bill?.service?.serviceReferenceNumber ?? '';
    }

    if (hasService()) {
      return item.service?.serviceReferenceNumber ?? '';
    }

    return '';
  }

  String getMenuName() {
    if (hasBill()) {
      return item.bill?.service?.menu?.name ?? '';
    }

    if (hasService()) {
      return item.service?.menu?.name ?? '';
    }

    return '';
  }

  String getItemTitle() {
    if (hasBill()) {
      return getBillNumber();
    }

    if (hasService()) {
      return getServiceRefNumber();
    }

    return '';
  }

  String getItemSubTitle() {
    return getMenuName();
  }

  String amountWithPrefix({
    String prefix = '',
  }) {
    return "$prefix ${moneyFormat(amount)}";
  }

  double get amount => item.amount;

  bool hasBill() {
    return item.bill != null && item.bill!.toJson().keys.length > 0;
  }

  bool hasExtraFieldTypeDate() {
    for (var i = 0; i < (item.details?.length ?? 0); i++) {
      var detail = item.details?[i];
      for (var j = 0; j < (detail?.extraFields?.length ?? 0); j++) {
        var extraField = detail?.extraFields?[j];
        if (extraField?.type == ExtraFieldType.date) {
          return true;
        }
      }
    }

    return false;
  }

  bool filledExtraFields() {
    for (var i = 0; i < (item.details?.length ?? 0); i++) {
      var detail = item.details?[i];
      for (var j = 0; j < (detail?.extraFields?.length ?? 0); j++) {
        var extraField = detail?.extraFields?[j];
        if (extraField?.value == null || extraField?.value == '') {
          return false;
        }
      }
    }

    return true;
  }

  bool selectable() {
    var result = payable();

    if (result) {
      result = getSubTotal() > 0;
    }

    if (result) {
      result = filledExtraFields();
    }

    return result;
  }

  bool payable() {
    var result = true;

    if (result && item.bill != null) {
      result = item.bill?.status == kActive;
    }

    if (result && item.service != null) {
      result = item.service?.status == kDisahkan;
    }

    if (result && item.bill?.service != null) {
      result = item.bill?.service?.status == kDisahkan;
    }

    return result;
  }

  bool hasService() {
    return item.service != null && item.service!.toJson().keys.length > 0;
  }

  bool isOrphan() {
    return !(hasService() || hasBill());
  }

  int getBillTypeId({
    int defaultBillTypeId = 1,
  }) {
    if (hasBill()) {
      return item.bill?.billTypeId ?? defaultBillTypeId;
    }

    if (hasService()) {
      return item.service?.billTypeId ?? defaultBillTypeId;
    }

    return defaultBillTypeId;
  }

  int getServiceId() {
    if (hasBill()) {
      return item.bill?.service?.id ?? 0;
    }

    if (hasService()) {
      return item.service?.id ?? 0;
    }

    return 0;
  }

  bool editableAmount() {
    return [2].contains(getBillTypeId());
  }

  bool editableMatrixRate() {
    return [4].contains(getBillTypeId());
  }

  bool needMatrix() {
    return [3, 4, 5].contains(getBillTypeId());
  }

  bool amountFromBill() {
    return [1].contains(getBillTypeId());
  }

  String getServiceName() {
    if (hasBill()) {
      return item.bill?.service?.name ?? '';
    }

    if (hasService()) {
      return item.service?.name ?? '';
    }

    return '';
  }

  double getSubTotal() {
    if (!needMatrix() || editableAmount()) {
      return CartItemUtils(item).amount;
    }

    List<CartMatrix> matrixs = item.details ?? [];

    double matrixTotal = 0.0;

    for (int im = 0; im < matrixs.length; im++) {
      var cartMatrix = matrixs[im];
      List<MatrixItemGroup> itemGroups = cartMatrix.items ?? [];

      for (var ig = 0; ig < itemGroups.length; ig++) {
        var group = itemGroups[ig];

        for (int isi = 0; isi < group.subitems.length; isi++) {
          var item = group.subitems[isi];

          for (var iq = 0; iq < item.quantities.length; iq++) {
            var quantity = item.quantities[iq];

            matrixTotal += quantity.getSubTotal();
          }
        }
      }
    }

    return matrixTotal;
  }
}
