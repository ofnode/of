#pragma once

#include <ofMain.h>

class ofApp : public ofBaseApp
{
    public:
        void setup  ();
        void update ();
        void draw   ();
        void exit   ();

        void keyPressed    (ofKeyEventArgs& key);
        void keyReleased   (ofKeyEventArgs& key);
        void mouseMoved    (ofMouseEventArgs& mouse);
        void mouseDragged  (ofMouseEventArgs& mouse);
        void mousePressed  (ofMouseEventArgs& mouse);
        void mouseReleased (ofMouseEventArgs& mouse);
        void windowResized (ofResizeEventArgs& resize);
        void gotMessage    (ofMessage message);
        void dragEvent     (ofDragInfo dragged);
};
