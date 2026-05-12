abstract class ISupportDatasource {
  Future<void> openSupportTicket({
    required String subject,
    required String description,
  });
}
