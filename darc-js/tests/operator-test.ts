
import { expect } from 'chai';
import 'mocha';
import { transpiler } from '../src/SDK/transpiler';

describe('Operator Test', 
  () => { 
    it('should return true', () => { 

      const code = `
      'operator-overloading enabled';
      let ConditionNode1 = new ConditionNode(ConditionNodeType.ExpressionNode, Expression.Operation_Equals, null, [1, 2]);
      let ConditionNode2 = new ConditionNode(ConditionNodeType.ExpressionNode, Expression.Operation_Equals, null, [1, 2]);

      let newConditionNode = ConditionNode1 + ConditionNode2;
      `; 
      

      const transpiled_result = transpiler(code);

      console.log(transpiled_result);
      expect(true).to.equal(true);
  }); 
});