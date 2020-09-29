const getResult = require('./script');

describe('Testing getResult', () => {
    test('4+5=9 ', () => {
        expect(getResult(4,5)).toBe(9);
    });
    test('4+15=19 ', () => {
        expect(getResult(4,15)).toBe(19);
    });
});