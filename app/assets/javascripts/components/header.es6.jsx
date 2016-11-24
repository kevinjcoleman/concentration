class Header extends React.Component {
  render () {
    return (
      <div className="row">
        <HeaderTitle game={this.props.game} opponent={this.props.opponent} />        
        <HeaderScoreboard opponent={this.props.opponent} game={this.props.game} />
      </div>
    );
  }
}