//
//  ContentView.swift
//  SquareAndTrangles
//
//  Created by Rashmi Aher on 15/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        EquilateralTriangleWithSquare(levels: 6)
            .stroke()
            .frame(width: UIScreen.main.bounds.width)
    }
}

struct EquilateralTriangleWithSquare: Shape {
    let levels: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()

        drawRecursiveShapes(path: &path, rect: rect, levels: levels)

        return path
    }

    private func drawRecursiveShapes(path: inout Path, rect: CGRect, levels: Int) {
        guard levels > 0 else {
            return
        }

        let centerX = rect.midX
        let centerY = rect.midY

        let sideLength = min(rect.width, rect.height)
        let halfSide = sideLength / 2

        let topPoint = CGPoint(x: centerX, y: centerY - halfSide)
        let leftPoint = CGPoint(x: centerX - halfSide, y: centerY + halfSide)
        let rightPoint = CGPoint(x: centerX + halfSide, y: centerY + halfSide)

        path.move(to: topPoint)
        path.addLine(to: leftPoint)
        path.addLine(to: rightPoint)
        path.addLine(to: topPoint)
        path.closeSubpath()

        let squareSize = sideLength / 2 // Square sides half the length of triangle side
        let squareOriginX = centerX - squareSize / 2
        let squareOriginY = centerY + halfSide - squareSize

        path.move(to: CGPoint(x: squareOriginX, y: squareOriginY))
        path.addLine(to: CGPoint(x: squareOriginX + squareSize, y: squareOriginY))
        path.addLine(to: CGPoint(x: squareOriginX + squareSize, y: squareOriginY + squareSize))
        path.addLine(to: CGPoint(x: squareOriginX, y: squareOriginY + squareSize))
        path.closeSubpath()

        let innerRect = CGRect(x: squareOriginX, y: squareOriginY, width: squareSize, height: squareSize)
        drawRecursiveShapes(path: &path, rect: innerRect, levels: levels - 1)
    }
}
