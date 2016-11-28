import React from 'react';
import ReactDOM from 'react-dom';

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
