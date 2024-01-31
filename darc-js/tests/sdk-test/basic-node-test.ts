import { expect } from 'chai';
import {Node, AND, OR, NOT, EXPRESSION, TRUE, FALSE, NodeType} from '../../src/SDK/Node';

import 'mocha';



describe('darc.js SDK Node test', 
  () => { 
    it('should pass test case 1', async () => { 

      // create a new AND node with 10 expression
      const andNode = new AND(
        new EXPRESSION(7),
        new EXPRESSION(1),
        new EXPRESSION(2),
      );

      // create a new OR node with 10 expression
      const orNode = new OR(
        new EXPRESSION(3),
        new EXPRESSION(4),
        new EXPRESSION(5),
      );

      const AND_and_OR = new AND(
        andNode,
        orNode,
      ); // this node will merge the andNode.

      // serialize the AND_and_OR node
      const serialized_AND_and_OR = AND_and_OR.generateConditionNodeList();

      // 8 nodes in total
      expect(serialized_AND_and_OR.length).to.equal(8);
      
      // all the nodes should have the correct id sequentially  
      for (let i = 0; i < serialized_AND_and_OR.length; i++) {
        expect(serialized_AND_and_OR[i].id).to.equal(BigInt(i));
      }

      // the first node should be AND node
      expect(serialized_AND_and_OR[0].nodeType).to.equal(2);
      expect(serialized_AND_and_OR[0].logicalOperator).to.equal(1);
  }); 

  it ('should pass test case 2', async () => {

    const expressionNode = new EXPRESSION(7);
    const result = expressionNode.generateConditionNodeList();
    expect(result.length).to.equal(1);
    expect(result[0].id).to.equal(BigInt(0));
  });

  it ('should pass test case 3', async () => {
    const trueNode = new TRUE();
    const result = trueNode.generateConditionNodeList();
    expect(result.length).to.equal(1);
    expect(result[0].id).to.equal(BigInt(0));
    expect (result[0].nodeType).to.equal(3);

    const falseNode = new FALSE();
    const result1 = falseNode.generateConditionNodeList();
    expect(result1.length).to.equal(1);
    expect(result1[0].id).to.equal(BigInt(0));
    expect (result1[0].nodeType).to.equal(4);

  });

  it ('should pass test case 4', async () => {

    const ORNode = new OR(
      new OR(
        new EXPRESSION(1),
        new EXPRESSION(2),
        new EXPRESSION(3),
      ),

      new OR(
        new EXPRESSION(4),
        new EXPRESSION(5),
        new EXPRESSION(6),
      ),

      new OR(
        new EXPRESSION(7),
        new EXPRESSION(8),
        new EXPRESSION(9),
      ),
    );

    // should be a big OR node with 9 expression nodes
    const result = ORNode.generateConditionNodeList();
    expect(result.length).to.equal(10);
    expect(result[0].nodeType).to.equal(2);
    expect(result[0].logicalOperator).to.equal(2);
    for (let i = 1; i < result.length; i++) {
      expect(result[i].nodeType).to.equal(1);
      expect(result[i].conditionExpression).to.equal(i);
      expect(result[i].logicalOperator).to.equal(0);
      expect(result[i].childList.length).to.equal(0);
    }

    // child list should be correct
    expect(result[0].childList.length).to.equal(9);
    for (let i = 1; i < result.length; i++) {
      expect(result[0].childList[i - 1]).to.equal(BigInt(i));
    }

  });

  it ('should pass test case 5', async () => {
    const ANDNode = new AND(
      new AND(
        new EXPRESSION(1),
        new EXPRESSION(2),
        new EXPRESSION(3),
      ),

      new AND(
        new EXPRESSION(4),
        new EXPRESSION(5),
        new EXPRESSION(6),
      ),

      new AND(
        new EXPRESSION(7),
        new EXPRESSION(8),
        new EXPRESSION(9),
      ),
    );

    // should be a big OR node with 9 expression nodes
    const result = ANDNode.generateConditionNodeList();
    expect(result.length).to.equal(10);
    expect(result[0].nodeType).to.equal(2);
    expect(result[0].logicalOperator).to.equal(1);
    for (let i = 1; i < result.length; i++) {
      expect(result[i].nodeType).to.equal(1);
      expect(result[i].conditionExpression).to.equal(i);
      expect(result[i].logicalOperator).to.equal(0);
      expect(result[i].childList.length).to.equal(0);
    }

    // child list should be correct
    expect(result[0].childList.length).to.equal(9);
    for (let i = 1; i < result.length; i++) {
      expect(result[0].childList[i - 1]).to.equal(BigInt(i));
    }
  });

});