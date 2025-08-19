(ns sig-app.client
  (:require [reagent.dom :refer [render]]))

(js/console.log "Hello World")

(defn ^:export init [params session]
  (render [:div "Welcome to SIG!"] (js/document.getElementById "app")))
