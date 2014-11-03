//
//  Linear.h
//  ACKeyboard
//
//  Created by Arnaud Coomans on 11/1/14.
//
//

#define MATRIX_2X2_DET( \
    a, b, \
    c, d) \
    ((a * d) - (b * c))

#define MATRIX_3X3_DET( \
    a, b, c, \
    d, e, f, \
    g, h, i) \
    (a * MATRIX_2X2_DET(e,f,h,i) \
    - b * MATRIX_2X2_DET(d,f,g,i) \
    + c * MATRIX_2X2_DET(d,e,g,h))

#define MATRIX_4X4_DET( \
    a, b, c, d, \
    e, f, g, h, \
    i, j, k, l, \
    m, n, o, p) \
    (a * MATRIX_3X3_DET(f,g,h,j,k,l,n,o,p) \
    - b * MATRIX_3X3_DET(e,g,h,i,k,l,m,o,p) \
    + c * MATRIX_3X3_DET(e,f,h,i,j,l,m,n,p) \
    - d * MATRIX_3X3_DET(e,f,g,i,j,k,m,n,o))


#define LINEAR_2X2_SOLVE_X( \
    a1, a2, \
    b1, b2, \
    c1, c2) \
    MATRIX_2X2_DET(c1, c2, b1, b2) / MATRIX_2X2_DET(a1, a2, b1, b2)

#define LINEAR_2X2_SOLVE_Y( \
    a1, a2, \
    b1, b2, \
    c1, c2) \
    MATRIX_2X2_DET(a1, a2, c1, c2) / MATRIX_2X2_DET(a1, a2, b1, b2)

#define LINEAR_EQ(p, arg1, res1, arg2, res2) \
    p * LINEAR_2X2_SOLVE_X(arg1, arg2, 1.0, 1.0, res1, res2) + LINEAR_2X2_SOLVE_Y(arg1, arg2, 1.0, 1.0, res1, res2)

