# E-commerce UI
This is a sample application for building an Elm 0.18 UI for an e-commerce api.

## Setup
* Install node.js and npm: e.g. on mac you can `brew install node` or use the installer
  * Confirm node version > 6.0 and npm > 2.0
  * `node --version`
  * `npm --version`
* Install elm 0.18
  * `npm install -g elm`
  * Confirm elm 0.18 `elm-make --version` (to install exactly elm 0.18 try `npm install -g elm@0.18`)
* Optional (tools that help with development)
  * [elm-live](https://github.com/tomekwi/elm-live) for automatic recompiling and reloading `npm install -g elm-live`
  * Syntax highlighting for your editor [Elm Guide](https://guide.elm-lang.org/install.html#configure-your-editor)
  * [elm-format](https://github.com/avh4/elm-format) is great for automatically formatting elm code on save in your editor
* Clone the repo
* Run `elm package install` in the repo dir to install all the packages (select yes as needed to install them)
* Compile the UI `elm make src/Inventory.elm --output elm.js`
* You can open the index.html file locally to see the UI after every compile (or setup elm-live to do it for you)

## API
The source for the backend API is in this repo [ecom-api](https://github.com/joestraitiff/ecom-api).  I used Rails 5.0.2 api-only for this.
