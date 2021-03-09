import React from 'react';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import SignUpContainer from './components/user/sign_up/SignUpContainer';
import Header from './components/navigation/Header';

function App() {
  return (
      <Router>
        <Header />
        <Switch>
          <Route exact path="/">
          </Route>
          <Route path="/sign_up">
            <SignUpContainer/>
          </Route>
        </Switch>
      </Router>
  );
}

export default App;
