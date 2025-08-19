(ns sig-app.handlers
  (:require [ring.util.codec     :refer [url-encode]]
            [ring.util.response  :refer [redirect]]            
            [triangulum.response :refer [no-cross-traffic?]]
            [triangulum.views    :refer [render-page]]))


(def home-page-handler (render-page "/main"))

(defn redirect-handler [{:keys [session query-string uri] :as _request}]
  (let [full-url (url-encode (str uri (when query-string (str "?" query-string))))]
    (redirect "/")))

(defn route-authenticator [{:keys [session headers] :as _request} auth-type]
  (let [user-id (:userId session -1)]
    (condp = auth-type
      :user     (pos? user-id)
      :collect  true      
      :no-cross (no-cross-traffic? headers)
      true)))
