(ns sig-app.routing
  (:require [triangulum.views :refer [render-page]]))

(def routes
  {[:get "/"] {:handler (render-page ("/main"))}})
