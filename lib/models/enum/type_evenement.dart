enum TypeEvenement {
  CONCERT,
  THEATRE,
  CINEMA,
  FESTIVAL,
  EXPOSITION,
  RELEASE_PARTY,
  MATCH;
  static TypeEvenement? fromString(String? type) {
    switch (type) {
      case 'CONCERT':
        return TypeEvenement.CONCERT;
      case 'THEATRE':
        return TypeEvenement.THEATRE;
      case 'CINEMA':
        return TypeEvenement.CINEMA;
      case 'FESTIVAL':
        return TypeEvenement.FESTIVAL;
      case 'EXPOSITION':
        return TypeEvenement.EXPOSITION;
      case 'RELEASE_PARTY':
        return TypeEvenement.RELEASE_PARTY;
      case 'MATCH':
        return TypeEvenement.MATCH;
      default:
        return null;
    }
  }
}