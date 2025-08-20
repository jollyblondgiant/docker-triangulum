import React from "react";
import ReactDOM from "react-dom";
export function pageInit(params, session) {
  ReactDOM.render(
    <div>Welcome to SigApp</div>,
    document.getElementById("app")
    );
}
