class Video {
  final List<Files> files;
  final String? folderName;

  Video({required this.files, required this.folderName});

  factory Video.fromJson(Map<String, dynamic> json) {
    final _files = json["files"] != null
        ? List<Files>.from(
            json["files"].map((item) => Files.fromJson(item)).toList())
        : <Files>[];
    final _folderName =
        json["folderName"] != null ? json["folderName"] as String : "";
    return Video(files: _files, folderName: _folderName);
  }
}

class Files {
  final String? album;
  final String? path;
  final String? dateAdded;
  final String? displayName;
  final String? duration;
  final String? size;

  Files(
      {required this.album,
      required this.path,
      required this.dateAdded,
      required this.displayName,
      required this.duration,
      required this.size});

  factory Files.fromJson(Map<String, dynamic> json) {
    final _album = json["album"] != null ? json["album"] as String : "";
    final _path = json["path"] != null ? json["path"] as String : "";
    final _dateAdded =
        json["dateAdded"] != null ? json["dateAdded"] as String : "";
    final _displayName =
        json["displayName"] != null ? json["displayName"] as String : "";
    final _duration =
        json["duration"] != null ? json["duration"] as String : "";
    final _size = json["size"] != null ? json["size"] as String : "";

    return Files(
        album: _album,
        path: _path,
        dateAdded: _dateAdded,
        displayName: _displayName,
        duration: _duration,
        size: _size);
  }
}
