import UIKit
import Ably
import Charts

class ViewController: UIViewController {
    
    let channel = Constants.channel
    var stockHistory: [Double] = [7.0, 10.0, 11.0, 12.0, 15.0, 11.5, 10.0, 10.6]
    var chartEntry = [ChartDataEntry]()
    var messageData: [NSArray] = []

    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .insideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .systemBlue
        
        chartView.animate(xAxisDuration: 2.5)
        
        return chartView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// Publish a message to the test channel
        channel.publish("INSERT NAME", data: stockHistory)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createChartView()

        /// Subscribe to messages on channel
        channel.subscribe("INSERT NAME") { message in
            if let msg = message.data as? NSArray {
                self.messageData.append(msg)
            }
            self.setChartData(array: self.messageData)
        }
    }
    
    func setChartData(array: [NSArray]) {
        
        for i in 0..<array[0].count {
            let nums = Double(i)
            let dataEntry = ChartDataEntry(x: nums, y: array[0][i] as! Double)
          chartEntry.append(dataEntry)
        }
        
        let set1 = LineChartDataSet(entries: chartEntry, label: "INSERT NAME")
        set1.mode = .linear
        set1.drawCirclesEnabled = false
        set1.setColor(.white)
        
        let chartData = LineChartData(dataSet: set1)
        chartData.setDrawValues(false)
        lineChartView.data = chartData
        
    }
    
    
    func createChartView() {
        view.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineChartView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lineChartView.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            lineChartView.heightAnchor.constraint(equalToConstant: 300),
            lineChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineChartView.leadingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
