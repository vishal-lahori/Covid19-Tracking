class Api {
  final String _url;

  final Map<String, String> _headers = {
    "x-rapidapi-host":
        "vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com",
    "x-rapidapi-key": "4c8f9f71c6msh8b9be3492f4e465p142c3ejsnaf56ecf17f26",
  };

  Api(this._url);

  String get url => _url;

  Map<String, String> get headers => _headers;
}
