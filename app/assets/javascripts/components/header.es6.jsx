class Header extends React.Component {
  render () {
    return (
      <h1>Play <strong className="text-upper">Concentration</strong> against {this.props.opponent.name}.</h1>
    );
  }
}