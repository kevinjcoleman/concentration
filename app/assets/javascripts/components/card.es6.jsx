import React from 'react';
import ReactDOM from 'react-dom';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group'

function CardTile(props) {
  return (
    <div>
      <ReactCSSTransitionGroup
        transitionName="example"
        transitionAppear={true}
        transitionAppearTimeout={500}
        transitionEnterTimeout={500}
        transitionLeaveTimeout={500}>
        <div className={"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center "+ props.className} onClick={props.handleClick}>
          {props.unicode ? props.unicode : <img className="diamond" src={props.imageUrl}></img>}
        </div>
      </ReactCSSTransitionGroup>
    </div>
  );
}

class Card extends React.Component {
  render() {
    //Alternate background colors of covered cards.
    var coveredClass = `covered ${this.props.order % 2 ? "red-covered" : "blue-covered"}`;
    //If it is not the current players turn AND the card has not been guessed or is not
    //currently flipped(One of the players 2 guesses that stays up at the end of the turn),
    //Keep the cards flipped over and don't add an onclick function.
    if (!this.props.isTurn && !(this.props.card.isGuessed || this.props.card.isFlipped)) {
      return (<CardTile className={coveredClass}
                        imageUrl={this.props.card.coveredImageUrl} />);
    }
    //If the card is guessed leave it flipped over and add a class to the card based on
    //whether the current player picked it or not.
    else if (this.props.card.isGuessed) {
      var pickClass = this.props.card.pickedByCurrentPlayer ? "blue" : "red"
      return (<CardTile unicode={this.props.card.unicode}
                        className={"flipped " + pickClass} />);
    }
    //If the card is flipped this turn, flip it over with a key so that it has a transition in and out.
    else if (this.props.card.isFlipped) {
      return (<CardTile key={`$this.props.card.id-flipped`}
                        unicode={this.props.card.unicode}
                        className="flipped" />);
    }
    // If none of the conditions are met keep the card covered and and add an onclick function.
    return (<CardTile className={coveredClass}
                      handleClick={this.props.onClick}
                      imageUrl={this.props.card.coveredImageUrl} />);
  }
}

export default Card
