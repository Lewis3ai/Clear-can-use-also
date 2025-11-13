#include <stdio.h>

int main(void) {
    double q1,q2,q3,p1,p2,p3;
    if (scanf("%lf %lf %lf %lf %lf %lf", &q1, &q2, &q3, &p1, &p2, &p3) != 6) {
        fprintf(stderr, "Error: expected 6 numbers (q1 q2 q3 p1 p2 p3)\n");
        return 1;
    }

    double s1 = q1 * p1;
    double s2 = q2 * p2;
    double s3 = q3 * p3;
    double total = s1 + s2 + s3;

    printf(" XYZ Shop\nPort of Spain, Trinidad\nPh. : 100 - 1000\n\n");
    printf("==========================\n");
    printf("              BILLING RECEIPT           \n\n");
    printf("==========================\n");
    printf("Product     Qty    Price    Subtotal \n");
    printf("----------------------------------------------\n");
    printf("Apples%12.2f  $%7.2f   $%7.2f\n", q1, p1, s1);
    printf("Oranges%10.2f  $%7.2f   $%7.2f\n", q2, p2, s2);
    printf("Bananas%10.2f  $%7.2f   $%7.2f\n", q3, p3, s3);
    printf("----------------------------------------------\n");
    printf("TOTAL%38s$%7.2f\n", " ", total);
    printf("==========================\n\n");
    printf("     THANK YOU FOR SHOPPING @ XYZ Shop\n");
    return 0;
}