#include <fcgi_stdio.h>

int main() {
    FCGX_Init();
    FCGX_Request req;
    FCGX_InitRequest(&req, 0, 0);
    while (FCGX_Accept_r(&req) >=0) {
        FCGX_PutS("Content-Type: text/html\n\n", req.out);
        FCGX_PutS("Hello, world!", req.out);
        FCGX_Finish_r(&req);
    }
    return 0;
}
