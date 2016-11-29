import React from 'react';
import ReactDOM from 'react-dom';
import CompletionBanner from './completion_banner.es6.jsx';

class HeaderTitle extends React.Component {
  render () {
    //Render a completion banner if the game is over, otherwise render the current turn.
    if (this.props.game.isCompleted) {
      return <CompletionBanner game={this.props.game} />;
    } else {
      return (
        <div className="col-md-8">
          <h1>Play <strong className="text-upper">Concentration</strong> against {this.props.game.opponentName}.</h1>
          <h3>{this.props.game.isTurn ? "It's your turn! 😎" : "It's " + this.props.game.opponentName +"'s turn. 😓"}</h3>
        </div>
      );
    }
  }
}

export default HeaderTitle
