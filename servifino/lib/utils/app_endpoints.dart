class AppEndpoints {
  static UserEndpoints user = UserEndpoints();
  static WorkerEndpoints worker = WorkerEndpoints();
  static OwnerEndpoints owner = OwnerEndpoints();
}

class UserEndpoints {
  final String createUser = "https://createuser-sap7hrqoga-uc.a.run.app";
  final String updateUser = "https://updateuser-sap7hrqoga-uc.a.run.app";
}

class WorkerEndpoints {
  final String getReservationsWaitingByUserId = "https://getreservationswaitingbyuserid-sap7hrqoga-uc.a.run.app";
  final String updateReservationStatus = 'https://us-central1-servifino.cloudfunctions.net/updateReservationStatus';
}

class OwnerEndpoints {
  final String addOrUpdateOwner = "https://addorupdateowner-sap7hrqoga-uc.a.run.app";
  final String getNonOwnerUsers = "https://getnonownerusers-sap7hrqoga-uc.a.run.app";
  final String addReservation = "https://addreservation-sap7hrqoga-uc.a.run.app";
  final String getReservationsSent = "https://us-central1-servifino.cloudfunctions.net/getReservationsSent";
}