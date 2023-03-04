const doIt = () => {
  try {
    const isSuccceeded = Math.random() < 0.5;

    if(isSuccceeded) {
      console.log('Fullfilled');
    } else {
      throw 1234;
    }

    return 'Returned';
  } catch (e) {
    console.error(e, ':', typeof e);
  } finally {
    console.log('Completed');
  }
};

const result = doIt() ?? "";
console.log(result);