#include "testApp.h"

int main()
{
    ofSetCurrentRenderer(ofGLProgrammableRenderer::TYPE);
    ofSetupOpenGL(640, 360, OF_WINDOW);
    ofRunApp(new testApp());
}
