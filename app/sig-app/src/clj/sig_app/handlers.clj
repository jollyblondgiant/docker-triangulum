(ns sig-app.handlers
  (:require [ring.util.response  :refer [redirect]]))


(defn redirect-handler [& _]
  (redirect ("/")))

(defn route-authenticator [& _] 
  true)

