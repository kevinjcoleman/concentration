import React from 'react';
import ReactDOM from 'react-dom';
import HeaderTitle from './header_title.es6.jsx';
import HeaderScoreboard from './header_scoreboard.es6.jsx';

class Header extends React.Component {
  render () {
    return (
      <div className="row">
        <HeaderTitle game={this.props.game} />
        <HeaderScoreboard game={this.props.game} />
      </div>
    );
  }
}

export default Header
