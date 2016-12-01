import React from 'react';
import {mount} from 'enzyme';
import CompletionBanner from '../completion_banner.es6.jsx';

describe('HeaderTitle', () => {
  it('when tie', () => {
    // Render a checkbox with label in the document
    var gameProps = {opponentName: "Kevin", isWinner: "tie"}
    var completionBannerNode = mount(<CompletionBanner game={gameProps} />);

    expect(completionBannerNode.find("h1").text()).toEqual(`Wow 🙃, you tied ${gameProps.opponentName}! 🤘`);
  });

  it('when win', () => {
    // Render a checkbox with label in the document
    var gameProps = {opponentName: "Kevin", isWinner: "winner"}
    var completionBannerNode = mount(<CompletionBanner game={gameProps} />);

    expect(completionBannerNode.find("h1").text()).toEqual(`Congrats 🏅 you beat ${gameProps.opponentName}! 👏`);
  });

  it('when loss', () => {
    // Render a checkbox with label in the document
    var gameProps = {opponentName: "Kevin", isWinner: "loser"}
    var completionBannerNode = mount(<CompletionBanner game={gameProps} />);

    expect(completionBannerNode.find("h1").text()).toEqual(`I'm sorry 😿, but you lost to ${gameProps.opponentName}. 👎`);
  });
});
