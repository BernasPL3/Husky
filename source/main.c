#include <3ds.h>
#include <citro3d.h>
#include <math.h>

typedef struct {
    float x, y, z;
    float vy;
} Player;

Player husky = {0, 0, 0, 0};

// câmera simples
float camX = 0;
float camY = 2;
float camZ = 5;

int main() {
    gfxInitDefault();
    consoleInit(GFX_TOP, NULL);

    C3D_Init();
    C3D_RenderTarget* top = C2D_CreateScreenTarget(GFX_TOP, GFX_LEFT);

    while (aptMainLoop()) {
        hidScanInput();
        u32 kHeld = hidKeysHeld();

        if (kHeld & KEY_START) break;

        // =====================
        // MOVIMENTO DO HUSKY
        // =====================
        if (kHeld & KEY_LEFT)  husky.x -= 0.1f;
        if (kHeld & KEY_RIGHT) husky.x += 0.1f;
        if (kHeld & KEY_UP)    husky.z -= 0.1f;
        if (kHeld & KEY_DOWN)  husky.z += 0.1f;

        // pulo
        if (kHeld & KEY_A && husky.y == 0) {
            husky.vy = 0.25f;
        }

        // gravidade
        husky.vy -= 0.015f;
        husky.y += husky.vy;

        if (husky.y < 0) {
            husky.y = 0;
            husky.vy = 0;
        }

        // =====================
        // CÂMERA (segue atrás)
        // =====================
        camX = husky.x;
        camY = husky.y + 2.0f;
        camZ = husky.z + 5.0f;

        // =====================
        // RENDER
        // =====================
        C3D_FrameBegin(C3D_FRAME_SYNCDRAW);
        C3D_FrameDrawOn(top);

        // Aqui ainda é placeholder visual
        // (no próximo passo viram cubos reais 3D)

        C3D_FrameEnd(0);
    }

    C3D_Fini();
    gfxExit();
    return 0;
}
