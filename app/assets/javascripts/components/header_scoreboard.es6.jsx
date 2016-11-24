class HeaderScoreboard extends React.Component {
  render () {
    return (
      <div className="col-md-4">
        <div className="list-group">
          <div className="list-group-item">
            <h3 className="list-group-item-heading text-center text-strong">Score</h3>
            <table className="table table-striped table-hover ">
              <thead>
                <tr>
                  <th></th>
                  <th className={"text-primary"}>You</th>
                  <th className={"text-danger"}>{this.props.opponent.name}</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><strong>Matches</strong></td>
                  <td className={"text-primary"}>{this.props.game.currentPlayerScore || 0 }</td>
                  <td className={"text-danger"}>{this.props.game.otherPlayerScore || 0 }</td>
                </tr>
                <tr>
                  <td><strong>Picks</strong></td>
                  <td className={"text-primary"}>{this.props.game.currentPlayerPicks || 0 }</td>
                  <td className={"text-danger"}>{this.props.game.otherPlayerPicks || 0 }</td>
                </tr>
              </tbody>
            </table> 
          </div>
        </div>
      </div>
    );
  }
}
