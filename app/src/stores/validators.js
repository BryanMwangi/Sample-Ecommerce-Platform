export const ve = (e) => {
  const er = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return er.test(e);
};

export const vp = (p) => {
  return p.length >= 6;
};

export const vn = (n) => {
  var re = /[\/\?<>\\:\*\|":]/g;
  let s = n.replace(re, "").trim();

  return s;
};

export const en = (n) => {
  const er = /^[A-Za-z\s'-À-ÖØ-öø-ÿ]+$/;
  return (
    typeof n === "string" &&
    !/\d/.test(n) &&
    !/`/.test(n) &&
    er.test(n) &&
    n.length >= 3
  );
};

export const un = (n) => {
  return n.replace("_", " ");
};
