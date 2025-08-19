import React from "react";
import ReactDOM from "react-dom";
export function pageInit(params, session) {
  const appRoot = document.getElementById("app");
  if (!appRoot.innerHTML){    
    ReactDOM.render(
      <div>Welcome to SigApp</div>,
      appRoot
    );
  }
}
