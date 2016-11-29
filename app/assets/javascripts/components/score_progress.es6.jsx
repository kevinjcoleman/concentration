import React from 'react';
import ReactDOM from 'react-dom';

class ScoreProgress extends React.Component {
  //See what percent of 12 the player score is.
  score(scoreNumber) {
    var totalPairs = 12;
    return (scoreNumber / totalPairs) * 100;
  }
  render () {
    return (
      <div className="progress progress-striped active">
        <div className="progress-bar progress-bar-primary" style={{width: this.score(this.props.game.currentPlayerScore) + "%"}}>{this.props.game.currentPlayerScore} matches</div>
        <div className="progress-bar progress-bar-danger" style={{width: this.score(this.props.game.otherPlayerScore) + "%", float: 'right'}}>{this.props.game.otherPlayerScore} matches</div>
      </div>
    );
  }
}

export default ScoreProgress
