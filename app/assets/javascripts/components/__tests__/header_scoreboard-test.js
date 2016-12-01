import React from 'react';
import {shallow} from 'enzyme';
import HeaderScoreboard from '../header_scoreboard.es6.jsx';

describe('HeaderTitle', () => {
  it('Renders final score correctly.', () => {
    // Render a checkbox with label in the document
    var gameProps = {opponentName: "Kevin",
                     isCompleted: true,
                     currentPlayerScore: 12,
                     otherPlayerScore: 0,
                     currentPlayerPicks: 25,
                     otherPlayerPicks: 14}
    var header = shallow(<HeaderScoreboard game={gameProps} />);

    expect(header.find("h3").text()).toEqual("Final score");
    expect(header.find("thead").text()).toEqual("YouKevin");
    expect(header.find("tbody").childAt(0).text()).toEqual("Matches120");
    expect(header.find("tbody").childAt(1).text()).toEqual("Picks2514");
  });
});
