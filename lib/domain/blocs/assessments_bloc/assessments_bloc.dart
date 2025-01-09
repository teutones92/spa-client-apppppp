import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/service/db_services/user_related_services/db_user_assessment_service/db_user_assessment_service.dart';
import 'package:spa_client_app/models/server/assessment_models/assessments_model/assessments_model.dart';

class AssessmentsBlocState {
  final bool isLoading;
  final AssessmentsModel? userAssessment;
  final List<AssessmentsModel> userHwAssessmentsList;
  final List<AssessmentsModel> userSwAssessmentsList;

  AssessmentsBlocState({
    this.isLoading = false,
    this.userAssessment,
    this.userHwAssessmentsList = const [],
    this.userSwAssessmentsList = const [],
  });

  AssessmentsBlocState copyWith({
    bool? isLoading,
    AssessmentsModel? userAssessment,
    List<AssessmentsModel>? userHwAssessmentsList,
    List<AssessmentsModel>? userSwAssessmentsList,
  }) {
    return AssessmentsBlocState(
      isLoading: isLoading ?? this.isLoading,
      userAssessment: userAssessment ?? this.userAssessment,
      userHwAssessmentsList:
          userHwAssessmentsList ?? this.userHwAssessmentsList,
      userSwAssessmentsList:
          userSwAssessmentsList ?? this.userSwAssessmentsList,
    );
  }
}

class AssessmentsBloc extends Cubit<AssessmentsBlocState> {
  AssessmentsBloc() : super(AssessmentsBlocState());

  /// Fetches the hardware assessment data from the database, sorts it by name,
  /// and updates the state with the sorted list.
  ///
  /// This method sets the loading state to true before fetching the data.
  /// Once the data is fetched and sorted, it updates the state with the sorted
  /// list and sets the loading state to false.
  ///
  /// The data is fetched from the 'user_hw_assessment' collection in the database.
  ///
  /// Throws an exception if there is an error during the database read operation.
  Future<void> getHwAssessment() async {
    emit(state.copyWith(isLoading: true));
    final data = await DbUserAssessment.read('user_hw_assessment');
    data.sort((a, b) => a.name.text.compareTo(b.name.text));
    emit(state.copyWith(userHwAssessmentsList: data, isLoading: false));
  }

  /// Fetches the SW assessment data from the database, sorts it by name,
  /// and updates the state with the sorted list and loading status.
  ///
  /// This method first sets the loading state to true, then reads the
  /// 'user_sw_assessment' data from the database. The data is sorted
  /// alphabetically by the `name` field. Finally, it updates the state
  /// with the sorted assessment list and sets the loading state to false.
  ///
  /// Throws:
  /// - Any exceptions thrown by the `DbUserAssessment.read` method.
  Future<void> getSwAssessment() async {
    emit(state.copyWith(isLoading: true));
    final data = await DbUserAssessment.read('user_sw_assessment');
    data.sort((a, b) => a.name.text.compareTo(b.name.text));
    emit(state.copyWith(userSwAssessmentsList: data, isLoading: false));
  }
}
