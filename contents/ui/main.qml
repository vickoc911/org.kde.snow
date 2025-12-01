/*
    SPDX-FileCopyrightText: 2015 Ivan Safonov <safonov.ivan.s@gmail.com>
    SPDX-FileCopyrightText: 2024 Steve Storey <sstorey@gmail.com>

    SPDX-License-Identifier: GPL-2.0-or-later
*/
import QtQuick
import QtQuick.Particles
import QtQuick3D
import QtQuick3D.Particles3D

import org.kde.plasma.plasmoid

WallpaperItem {
    id: wallpaper
    Image {
        id: root
        anchors.fill: parent

        fillMode: wallpaper.configuration.FillMode
        source: wallpaper.configuration.Image

        readonly property int velocity: wallpaper.configuration.Velocity
        readonly property int numParticles: wallpaper.configuration.Particles
        readonly property int particleSize: wallpaper.configuration.Size
        readonly property int particleLifeSpan: 1.5 * height / velocity

    View3D {
        anchors.fill: parent

        environment: SceneEnvironment {
            clearColor: "#202020"
            backgroundMode: SceneEnvironment.Transparent
            antialiasingMode: SceneEnvironment.MSAA
        }

        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 100, 600)
            clipFar: 2000
        }

        PointLight {
            position: Qt.vector3d(200, 600, 400)
            brightness: 40
            ambientColor: Qt.rgba(0.2, 0.2, 0.2, 1.0)
        }


ParticleSystem3D {
    id: snow
    x: 50
    y: 300
    ParticleEmitter3D {
        id: snowEmitter
        emitRate: root.numParticles
        lifeSpan: 4000
        particle: snowParticle
        particleScale: root.particleSize
        particleScaleVariation: 1
        velocity: snowDirection
        shape: snowShape

        VectorDirection3D {
            id: snowDirection
            direction.y: -100
            direction.z: 0
        }

        SpriteParticle3D {
            id: snowParticle
            color: "#dcdcdc"
            maxAmount: 5000
            particleScale: 1
            sprite: snowTexture
            billboard: true

            Texture {
                id: snowTexture
                source: wallpaper.configuration.Snowflake
            }
        }
    }
    ParticleShape3D {
        id: snowShape
        fill: true
        extents.x: 400
        extents.y: 1
        extents.z: 400
        type: ParticleShape3D.Cube
    }

    Wander3D {
        id: wander
        globalPace.x: 0.01
        globalAmount.x: -500
        uniqueAmount.x: 50
        uniqueAmount.y: 20
        uniqueAmount.z: 50
        uniqueAmountVariation: 0.1
        uniquePaceVariation: 0.2
        uniquePace.x: 0.03
        uniquePace.z: 0.03
        uniquePace.y: 0.01
        particles: snowParticle
    }
}


}
}
}

