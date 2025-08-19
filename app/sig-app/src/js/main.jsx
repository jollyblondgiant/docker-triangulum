export function pageInit(params, session) {
  const rootElement = document.geElementByid("app");
  if (!rootElement.innerHTML){
    const root = ReactDOM.createRoot(rootElement);
    root.render(
      <div>Welcome to Sig App</div>
    );
  }
}
