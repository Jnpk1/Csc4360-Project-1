class socialMediaCard {
  String socialMediaUrl = '';

  socialMediaCard(String m) {
    this.socialMediaUrl = m;
  }

  String toString() {
    return "Social Media ($socialMediaUrl)";
  }
}
