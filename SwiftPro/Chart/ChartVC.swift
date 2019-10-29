//
//  ChartVC.swift
//  SwiftPro
//
//  Created by eport on 2019/8/6.
//  Copyright © 2019 eport. All rights reserved.
//

import SwiftCharts
import UIKit

class ChartVC: BaseWithNaviVC {
    fileprivate var chart: Chart?

    let sideSelectorHeight: CGFloat = 50

    fileprivate func barsChart(horizontal: Bool) -> Chart {
        let tuplesXY = [(2, 8), (4, 9), (6, 10), (8, 12), (12, 17)]

        func reverseTuples(_ tuples: [(Int, Int)]) -> [(Int, Int)] {
            return tuples.map { ($0.1, $0.0) }
        }

        let chartPoints = (horizontal ? reverseTuples(tuplesXY) : tuplesXY).map { ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1)) }

        let labelSettings = ChartLabelSettings(font: .boldSystemFont(ofSize: 12.0))

        let generator = ChartAxisGeneratorMultiplier(2)
        let labelsGenerator = ChartAxisLabelsGeneratorFunc { scalar in
            ChartAxisLabel(text: "\(scalar)", settings: labelSettings)
        }
        let xGenerator = ChartAxisGeneratorMultiplier(2)

        let xModel = ChartAxisModel(firstModelValue: 0, lastModelValue: 20, axisTitleLabels: [ChartAxisLabel(text: "Axis title", settings: labelSettings)], axisValuesGenerator: xGenerator, labelsGenerator: labelsGenerator)
        let yModel = ChartAxisModel(firstModelValue: 0, lastModelValue: 20, axisTitleLabels: [ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical())], axisValuesGenerator: generator, labelsGenerator: labelsGenerator)

        let barViewGenerator = { (chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, _: Chart) -> UIView? in
            let bottomLeft = layer.modelLocToScreenLoc(x: 0, y: 0)

            let barWidth: CGFloat = 30

            let settings = ChartBarViewSettings(animDuration: 0.5)

            let (p1, p2): (CGPoint, CGPoint) = {
                if horizontal {
                    return (CGPoint(x: bottomLeft.x, y: chartPointModel.screenLoc.y), CGPoint(x: chartPointModel.screenLoc.x, y: chartPointModel.screenLoc.y))
                } else {
                    return (CGPoint(x: chartPointModel.screenLoc.x, y: bottomLeft.y), CGPoint(x: chartPointModel.screenLoc.x, y: chartPointModel.screenLoc.y))
                }
            }()
            return ChartPointViewBar(p1: p1, p2: p2, width: barWidth, bgColor: UIColor.blue.withAlphaComponent(0.6), settings: settings)
        }

        let frame = ExamplesDefaults.chartFrame(view.bounds)
        let chartFrame = chart?.frame ?? CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height - sideSelectorHeight)

        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom

        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)

        let chartPointsLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: barViewGenerator)

        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)

        return Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLayer,
            ]
        )
    }

    fileprivate func showChart(horizontal: Bool) {
        self.chart?.clearView()

        let chart = barsChart(horizontal: horizontal)
        view.addSubview(chart.view)
        self.chart = chart
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        showChart(horizontal: false)
        if let chart = chart {
            let sideSelector = DirSelector(frame: CGRect(x: 0, y: chart.frame.origin.y + chart.frame.size.height, width: view.frame.size.width, height: sideSelectorHeight), controller: self)
            view.addSubview(sideSelector)
        }
    }

    class DirSelector: UIView {
        let horizontal: UIButton
        let vertical: UIButton

        weak var controller: ChartVC?

        fileprivate let buttonDirs: [UIButton: Bool]

        init(frame: CGRect, controller: ChartVC) {
            self.controller = controller

            horizontal = UIButton()
            horizontal.setTitle("Horizontal", for: UIControl.State())
            vertical = UIButton()
            vertical.setTitle("Vertical", for: UIControl.State())

            buttonDirs = [horizontal: true, vertical: false]

            super.init(frame: frame)

            addSubview(horizontal)
            addSubview(vertical)

            for button in [horizontal, vertical] {
                button.titleLabel?.font = ExamplesDefaults.fontWithSize(14)
                button.setTitleColor(UIColor.blue, for: UIControl.State())
                button.addTarget(self, action: #selector(DirSelector.buttonTapped(_:)), for: .touchUpInside)
            }
        }

        @objc func buttonTapped(_ sender: UIButton) {
            let horizontal = sender == self.horizontal ? true : false
            controller?.showChart(horizontal: horizontal)
        }

        override func didMoveToSuperview() {
            let views = [horizontal, vertical]
            for v in views {
                v.translatesAutoresizingMaskIntoConstraints = false
            }

            let namedViews = views.enumerated().map { index, view in
                ("v\(index)", view)
            }

            var viewsDict = [String: UIView]()
            for namedView in namedViews {
                viewsDict[namedView.0] = namedView.1
            }

            let buttonsSpace: CGFloat = 10

            let hConstraintStr = namedViews.reduce("H:|") { str, tuple in
                "\(str)-(\(buttonsSpace))-[\(tuple.0)]"
            }

            let vConstraits = namedViews.flatMap { NSLayoutConstraint.constraints(withVisualFormat: "V:|[\($0.0)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict) }

            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: hConstraintStr, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict)
                + vConstraits)
        }

        required init(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

struct ExamplesDefaults {
    static var chartSettings: ChartSettings {
        return iPhoneChartSettings
    }

    static var chartSettingsWithPanZoom: ChartSettings {
        return iPhoneChartSettingsWithPanZoom
    }

    fileprivate static var iPadChartSettings: ChartSettings {
        var chartSettings = ChartSettings()
        chartSettings.leading = 20
        chartSettings.top = 20
        chartSettings.trailing = 20
        chartSettings.bottom = 20
        chartSettings.labelsToAxisSpacingX = 10
        chartSettings.labelsToAxisSpacingY = 10
        chartSettings.axisTitleLabelsToLabelsSpacing = 5
        chartSettings.axisStrokeWidth = 1
        chartSettings.spacingBetweenAxesX = 15
        chartSettings.spacingBetweenAxesY = 15
        chartSettings.labelsSpacing = 0
        return chartSettings
    }

    fileprivate static var iPhoneChartSettings: ChartSettings {
        var chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        chartSettings.labelsSpacing = 0
        return chartSettings
    }

    fileprivate static var iPadChartSettingsWithPanZoom: ChartSettings {
        var chartSettings = iPadChartSettings
        chartSettings.zoomPan.panEnabled = true
        chartSettings.zoomPan.zoomEnabled = true
        return chartSettings
    }

    fileprivate static var iPhoneChartSettingsWithPanZoom: ChartSettings {
        var chartSettings = iPhoneChartSettings
        chartSettings.zoomPan.panEnabled = true
        chartSettings.zoomPan.zoomEnabled = true
        return chartSettings
    }

    static func chartFrame(_ containerBounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 70, width: containerBounds.size.width, height: containerBounds.size.height - 70)
    }

    static var labelSettings: ChartLabelSettings {
        return ChartLabelSettings(font: ExamplesDefaults.labelFont)
    }

    static var labelFont: UIFont {
        return ExamplesDefaults.fontWithSize(11)
    }

    static var labelFontSmall: UIFont {
        return ExamplesDefaults.fontWithSize(10)
    }

    static func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static var guidelinesWidth: CGFloat {
        return 0.1
    }

    static var minBarSpacing: CGFloat {
        return 5
    }
}
