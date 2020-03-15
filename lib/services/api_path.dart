class APIPath {
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  static String jobs(String uid) => 'users/$uid/jobs';

  // FOR ENTRIES
  static String entry(String uid, String entryId) =>
      'users/$uid/entries/$entryId';
  static String entries(String uid) => 'users/$uid/entries';

  // FOR BARBER
  static String barber(String uid) => 'barbers/$uid';
}
