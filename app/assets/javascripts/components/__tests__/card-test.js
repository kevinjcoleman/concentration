import React from 'react';
import {mount, shallow} from 'enzyme';
import sinon from 'sinon';
import Card from '../card.es6.jsx';

describe('Card', () => {
  describe('when not turn', () => {
    const onClick = sinon.spy();

    var cardProps = {card: {id: 1,
                            isGuessed: false,
                            isFlipped: false,
                            pickedByCurrentPlayer: false,
                            coveredImageUrl: "/foo.url" },
                     isTurn: false,
                     order: 0 };
    describe('not flipped or guessed', () => {
      it('is covered ', () => {
        const cardNode = mount(<Card card={cardProps.card}
                                     isTurn={cardProps.isTurn}
                                     order={cardProps.order}
                                     index={0}
                                     onClick={onClick}
                                  />);
        expect(cardNode.find(".card").html()).toEqual("<div class=\"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center covered blue-covered example-appear\"><img class=\"diamond\" src=\"/foo.url\"></div>");
      });

      it('isn\'t clickable ', () => {
        const cardNode = mount(<Card card={cardProps.card}
                                     isTurn={cardProps.isTurn}
                                     order={cardProps.order}
                                     index={0}
                                     onClick={onClick}
                                  />);
        cardNode.find(".card").simulate('click');
        expect(onClick.calledOnce).toEqual(false);
      });
    });
    describe('flipped or guessed', () => {
      it("is flipped with unicode if flipped", () => {
        cardProps.card.isFlipped = true;
        cardProps.card.unicode = '🙃';
        const cardNode = mount(<Card card={cardProps.card}
                                     isTurn={cardProps.isTurn}
                                     order={cardProps.order}
                                     index={0}
                                     onClick={onClick}
                                  />);
        expect(cardNode.find(".card").html()).toEqual("<div class=\"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center flipped example-appear\">🙃</div>");
      });

      it("is flipped with unicode if guessed", () => {
        cardProps.card.isGuessed = true;
        cardProps.card.unicode = '🙃';
        const cardNode = mount(<Card card={cardProps.card}
                                     isTurn={cardProps.isTurn}
                                     order={cardProps.order}
                                     index={0}
                                     onClick={onClick}
                                  />);
        expect(cardNode.find(".card").html()).toEqual("<div class=\"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center flipped red example-appear\">🙃</div>");
      });
    });
  });

  describe('when turn', () => {
    const onClick = sinon.spy();

    var cardProps = {card: {isGuessed: false,
                            isFlipped: false,
                            pickedByCurrentPlayer: false,
                            coveredImageUrl: "/foo.url" },
                     isTurn: true,
                     order: 0 };
    describe('not flipped or guessed', () => {
      const cardNode = mount(<Card card={cardProps.card}
                                   isTurn={cardProps.isTurn}
                                   order={cardProps.order}
                                   index={0}
                                   onClick={onClick}
                                />);
      it('is covered ', () => {
        expect(cardNode.find(".card").html()).toEqual("<div class=\"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center covered blue-covered example-appear\"><img class=\"diamond\" src=\"/foo.url\"></div>");
      });

      it('is clickable', () => {
        var server = sinon.fakeServer.create();
        server.autoRespond = true;
        server.respondWith("GET", "/cards/1.json", [
          200,
          {"Content-Type": "application/json"},
          JSON.stringify('{ "unicode": "🙃", "name": "upside_downface" }')
        ]);
        cardNode.find(".card").simulate('click');
        expect(onClick.calledOnce).toEqual(true);
        server.restore();
      });

      it('flips when clicked', () => {
        var server = sinon.fakeServer.create();
        server.autoRespond = true;
        server.respondWith("GET", "cards/1", [
          200,
          {"Content-Type": "application/json"},
          JSON.stringify('{ "unicode": 🙃, "name": "upside_downface" }')
        ]);
        cardNode.find(".card").simulate('click');
        expect(cardNode.find(".card").html()).toEqual("<div class=\"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center flipped example-appear\">🙃</div>");
        server.restore();
      });

    });

    describe('flipped or guessed', () => {
      it("is flipped with unicode if flipped", () => {
        cardProps.card.isFlipped = true;
        cardProps.card.unicode = '🙃';
        const cardNode = mount(<Card card={cardProps.card}
                                     isTurn={cardProps.isTurn}
                                     order={cardProps.order}
                                     index={0}
                                     onClick={onClick}
                                  />);
        expect(cardNode.find(".card").html()).toEqual("<div class=\"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center flipped example-appear\">🙃</div>");
      });

      it("is flipped with unicode if guessed", () => {
        cardProps.card.isGuessed = true;
        cardProps.card.unicode = '🙃';
        const cardNode = mount(<Card card={cardProps.card}
                                     isTurn={cardProps.isTurn}
                                     order={cardProps.order}
                                     index={0}
                                     onClick={onClick}
                                  />);
        expect(cardNode.find(".card").html()).toEqual("<div class=\"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center flipped red example-appear\">🙃</div>");
      });
    });
  });
});
