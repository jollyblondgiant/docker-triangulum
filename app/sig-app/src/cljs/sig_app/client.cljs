(ns sig-app.client
  (:require [reagent.dom :refer [render]]))

(defn ^:export init [params session]
  (render [] (js/document.getElementById "sig-app")))
