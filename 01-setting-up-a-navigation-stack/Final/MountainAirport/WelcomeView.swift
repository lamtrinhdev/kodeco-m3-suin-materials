/// Copyright (c) 2024 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct WelcomeView: View {
  @StateObject var flightInfo = FlightData()
  @State private var hidePast = false

  var shownFlights: [FlightInformation] {
    hidePast ?
    flightInfo.flights.filter { $0.localTime >= Date() } :
    flightInfo.flights
  }

  var body: some View {
    NavigationStack {
      ZStack(alignment: .topLeading) {
        // Background
        Image("welcome-background")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 375, height: 130)
          .clipped()
        // Title
        VStack {
          Text("Mountain Airport")
            .font(.system(size: 28.0, weight: .bold))
          Text("Flight Status")
        }
        .foregroundColor(.white)
        .padding()
      }
      .font(.title)
      // swiftlint:disable trailing_closure
      List(shownFlights) { flight in
        // 1
        NavigationLink(flight.statusBoardName, value: flight)
      }
      // swiftlint:enable trailing_closure
      // 2
      .navigationDestination(
        // 3
        for: FlightInformation.self,
        // 4
        destination: { flight in
          FlightDetails(flight: flight)
        }
      )
      .listStyle(.plain)
      .navigationTitle("Mountain Airport")
      // swiftlint:disable trailing_closure
      .navigationBarItems(
        trailing: Button(
          hidePast ? "Show Past" : "Hide Past",
          action: {
            hidePast.toggle()
          }
        )
        // swiftlint:enable trailing_closure
      )
      Spacer()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
