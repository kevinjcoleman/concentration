import React from 'react';
import {shallow} from 'enzyme';
import Header from '../header.es6.jsx';

describe('Header', () => {
  it('Renders child components correctly.', () => {
    // Render a checkbox with label in the document
    var gameProps = {opponentName: "Kevin", isWinner: "tie"}
    var header = shallow(<Header game={gameProps} />);

    expect(header.text()).toEqual("<HeaderTitle /><HeaderScoreboard />");
  });
});  
