import { expect } from 'chai';
import {Node, AND, OR, NOT, EXPRESSION, TRUE, FALSE, NodeType} from '../../src/SDK/conditionNodes/Node';

import 'mocha';



describe.only('class DARC test', 
  () => { 
    it('should return true', async () => { 

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
      );

      // serialize the AND_and_OR node
      const serialized_AND_and_OR = AND_and_OR.generateConditionNodeList();

      console.log(serialized_AND_and_OR);
  }); 
});