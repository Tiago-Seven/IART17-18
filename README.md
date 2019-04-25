# IART
IrresponsibleAdultsReviveTechnology

Example:
![Example image](/exemplo.png?raw=true)

* Accepts voice or text inputs
* Processes it and returns a response using the [gramatica.pl file](/gramatica.pl) (written in Prolog) (hotel database in the beginning of the [dados.pl file](/dados.pl) )
* The response is displayed and read

Voice input using the [Web Speech API](https://developers.google.com/web/updates/2013/01/Voice-Driven-Web-Apps-Introduction-to-the-Web-Speech-API) by Google

Response is read using [SpeechSynthesisUtterance](https://developer.mozilla.org/pt-BR/docs/Web/API/SpeechSynthesisUtterance) by Mozilla

How to Run:
* Open index.html with a live server
* Consult frontend/server.pl with [SICStus Prolog](https://sicstus.sics.se/)
* Run `server.` in the SICStus console
* Voice input is made by holding down on the microphone icon
