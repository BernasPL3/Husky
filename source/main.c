#include <3ds.h>
#include <citro3d.h>

typedef struct {
    float x, y, z;
    float vy;
} Player;

int main() {
    gfxInitDefault();
    consoleInit(GFX_TOP, NULL);

    C3D_Init();
    C3D_RenderTarget* top = C2D_CreateScreenTarget(GFX_TOP, GFX_LEFT);

    Player husky = {0.0f, 0.0f, 0.0f, 0.0f};

    while (aptMainLoop()) {
        hidScanInput();
        u32 kHeld = hidKeysHeld();

        if (kHeld & KEY_START) break;

        // ===== MOVIMENTO DO HUSKY =====
        if (kHeld & KEY_LEFT)  husky.x -= 0.1f;
        if (kHeld & KEY_RIGHT) husky.x += 0.1f;
        if (kHeld & KEY_UP)    husky.z -= 0.1f;
        if (kHeld & KEY_DOWN)  husky.z += 0.1f;

        // pulo simples
        if (kHeld & KEY_A && husky.y == 0.0f) {
            husky.vy = 0.25f;
        }

        // gravidade
        husky.vy -= 0.015f;
        husky.y += husky.vy;

        if (husky.y < 0.0f) {
            husky.y = 0.0f;
            husky.vy = 0.0f;
        }

        // ===== RENDER =====
        C3D_FrameBegin(C3D_FRAME_SYNCDRAW);
        C3D_FrameDrawOn(top);

        // Aqui você vai desenhar o Husky como cubo (placeholder)

        C3D_FrameEnd(0);
    }

    C3D_Fini();
    gfxExit();
    return 0;
}
