import SwiftUI
import Metal

struct BasicColorShaderView: View {
    var body: some View {
        Rectangle()
            .colorEffect(ShaderLibrary.basicColor())
            .frame(width: 300, height: 300)
    }
}


struct GradientShaderView: View {
    var body: some View {
        Rectangle()
            .colorEffect(ShaderLibrary.gradient())
            .frame(width: 300, height: 300)
    }
}
//hello

struct CheckerboardView: View {
    var body: some View {
        Rectangle()
            .colorEffect(ShaderLibrary.checkboard(.float(30), .color(.yellow)))
            .frame(width: 300, height: 300)
    }
}


struct AnimatedColorShaderView: View {
    @State private var startTime = Date()
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Rectangle()
                .fill(.white)
                .colorEffect(
                    ShaderLibrary.animatedColor(
                        .float(timeline.date.timeIntervalSince(startTime))
                    )
                )
                .frame(width: 300, height: 300)
        }
    }
}


struct DistortionShaderView: View {
    @State private var startTime = Date()
    
    var body: some View {
        TimelineView(.animation) { timeline in
            VStack(spacing: 20) {
                Text("Hello, Metal!")
                    .font(.system(size: 40, weight: .bold))
                
                Image(systemName: "swift")
                    .font(.system(size: 80))
                    .foregroundStyle(.orange)
            }
            .layerEffect(
                ShaderLibrary.waveDistortion(
                    .float(timeline.date.timeIntervalSince(startTime))
                ),
                maxSampleOffset: CGSize(width: 20, height: 20)
            )
            .frame(width: 300, height: 300)
        }
    }
}


struct ParametricShaderView: View {
    @State private var intensity: Float = 0.5
    @State private var frequency: Float = 10.0
    @State private var startTime = Date()
    
    var body: some View {
        TimelineView(.animation) { timeline in
            VStack(spacing: 30) {
                Rectangle()
                    .fill(.white)
                    .colorEffect(
                        ShaderLibrary.waves(
                            .float(timeline.date.timeIntervalSince(startTime)),
                            .float(intensity),
                            .float(frequency)
                        )
                    )
                    .frame(width: 300, height: 300)
                
                VStack(spacing: 15) {
                    HStack {
                        Text("Intensity:")
                        Slider(value: $intensity, in: 0...1)
                    }
                    
                    HStack {
                        Text("Frequency:")
                        Slider(value: $frequency, in: 1...50)
                    }
                }
                .padding()
            }
        }
    }
}


struct ImageProcessingShaderView: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            Image(systemName: "globe.americas.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.blue)
                .layerEffect(
                    ShaderLibrary.pixelate(
                        .float(10.0) // pixel size
                    ),
                    maxSampleOffset: CGSize(width: 0, height: 0)
                )
                .frame(width: 300, height: 300)
        }
    }
}


struct PlasmaShaderView: View {
    @State private var startTime = Date()
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Rectangle()
                .fill(.black)
                .colorEffect(
                    ShaderLibrary.plasma(
                        .float(timeline.date.timeIntervalSince(startTime))
                    )
                )
                .frame(width: 300, height: 300)
        }
    }
}


struct KaleidoscopeShaderView: View {
    @State private var startTime = Date()
    @State private var segments: Float = 6.0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            VStack(spacing: 20) {
                Rectangle()
                    .fill(.black)
                    .colorEffect(
                        ShaderLibrary.kaleidoscope(
                            .float(timeline.date.timeIntervalSince(startTime)),
                            .float(segments)
                        )
                    )
                    .frame(width: 300, height: 300)
                
                VStack(spacing: 10) {
                    HStack {
                        Text("Segments:")
                        Slider(value: $segments, in: 3...12, step: 1)
                        Text("\(Int(segments))")
                            .frame(width: 30)
                    }
                    Text("Controls the number of mirror sections")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
        }
    }
}


struct TunnelShaderView: View {
    @State private var startTime = Date()
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Rectangle()
                .fill(.black)
                .colorEffect(
                    ShaderLibrary.tunnel(
                        .float(timeline.date.timeIntervalSince(startTime))
                    )
                )
                .frame(width: 300, height: 300)
        }
    }
}


struct MetalShadersDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                Group {
                    Text("Metal Shaders in SwiftUI")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your First Shader: basicColor")
                            .font(.headline)
                        BasicColorShaderView()
                        Text("A simple shader that outputs a solid color")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Using Position: The Gradient Shader")
                            .font(.headline)
                        GradientShaderView()
                        Text("Uses pixel position to create a gradient")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Custom Parameters: The Chessboard")
                            .font(.headline)
                        CheckerboardView()
                        Text("Uses pixel position to create a chessboard")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Animations: Time-Based Shaders")
                            .font(.headline)
                        AnimatedColorShaderView()
                        Text("Animates colors over time")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Group {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Example 4: Wave Distortion")
                            .font(.headline)
                        DistortionShaderView()
                        Text("Distorts the view with a wave effect")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Example 5: Parametric Waves")
                            .font(.headline)
                        ParametricShaderView()
                        Text("Interactive shader with custom parameters")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Example 6: Image Processing")
                            .font(.headline)
                        ImageProcessingShaderView()
                        Text("Pixelates an image")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Example 7: Plasma Effect")
                            .font(.headline)
                        PlasmaShaderView()
                        Text("Mesmerizing plasma using multiple sine waves")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Example 8: Kaleidoscope")
                            .font(.headline)
                        KaleidoscopeShaderView()
                        Text("Rotational symmetry creates beautiful patterns")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Example 9: Tunnel/Wormhole")
                            .font(.headline)
                        TunnelShaderView()
                        Text("3D-like tunnel effect using polar coordinates")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()
        }
    }
}


#Preview {
    MetalShadersDemo()
}
