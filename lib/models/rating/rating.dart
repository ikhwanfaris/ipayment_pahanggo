// ignore_for_file: non_constant_identifier_names

import 'dart:core';

class RatingSetting {
// "id": 2,
//             "rating_id": null,
//             "non_rater": null,
//             "3_stars_rater": null,
//             "overall_rating_lower_3": null,
//             "start_date": "2022-11-02",
//             "end_date": "2022-11-27",
//             "number_of_star": 5,
//id: 3, rating_id: null, non_rater: null, 3_stars_rater: null, overall_rating_lower_3: null, start_date: 2022-11-07, end_date: 2022-11-18, number_of_star: 4, created_at: 2022-11-07T01:16:47.000000Z, updated_at: 2022-11-07T01:17:50.000000Z
  int? id;
  String? rating_id;
  String? non_rater;
  String? overall_rating_lower_3;
  String? start_date;
  String? end_date;
  String? created_at;
  String? updated_at;

  RatingSetting(List data,
      {this.id,
      this.rating_id,
      this.non_rater,
      this.end_date,
      this.overall_rating_lower_3,
      this.start_date,
      this.created_at,
      this.updated_at});

  RatingSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating_id = json['rating_id'];
    non_rater = json['non_rater'];
    end_date = json['end_date'];
    overall_rating_lower_3 = json['overall_rating_lower_3'];
    start_date = json['start_date'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}
