function CardTile(props) {
  return (
    <div className={"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center "+ props.className} onClick={props.handleClick}>
      {props.unicode ? props.unicode : ''}
    </div>
  );
}

class Card extends React.Component {
  render() {
    if (!this.props.isTurn && !(this.props.card.isGuessed || this.props.card.isFlipped)) {
      return (
        <CardTile className="covered" /> 
      );
    }
    else if (this.props.card.isGuessed) {
      pickClass = this.props.card.pickedByCurrentPlayer ? "blue" : "red"
      return (
        <CardTile unicode={this.props.card.unicode} 
          className={"flipped " + pickClass} /> 
      );
    }
    else if (this.props.card.isFlipped) {
      return (
        <CardTile unicode={this.props.card.unicode} 
          className="flipped" /> 
        );
    }
    return (
      <CardTile className="covered"
        handleClick={this.props.onClick} />  
    );
  }
}