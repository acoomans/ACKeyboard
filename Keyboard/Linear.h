//
//  Linear.h
//  ACKeyboard
//
//  Created by Arnaud Coomans on 11/1/14.
//
//

#define MATRIX_DET(a, b, c, d) ((a * d) - (b * c))

#define MATRIX_SOLVE_X(a1, a2, b1, b2, c1, c2) \
    MATRIX_DET(c1, c2, b1, b2) / MATRIX_DET(a1, a2, b1, b2)
#define MATRIX_SOLVE_Y(a1, a2, b1, b2, c1, c2) \
    MATRIX_DET(a1, a2, c1, c2) / MATRIX_DET(a1, a2, b1, b2)

#define LINEAR_EQ(p, arg1, res1, arg2, res2) \
    p * MATRIX_SOLVE_X(arg1, arg2, 1.0, 1.0, res1, res2) + MATRIX_SOLVE_Y(arg1, arg2, 1.0, 1.0, res1, res2)
