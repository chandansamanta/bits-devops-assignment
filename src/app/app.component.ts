import { CommonModule } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, HttpClientModule, CommonModule, FormsModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'bits-devops-assignment';
  listOfUser: any[] = [];
  name: string = '';
  mobile: string = '';
  address: string = '';
  constructor(private httpclient: HttpClient) {
    this.loadUser();
  }
  save() {
    this.httpclient.post('https://fzikk1yudi.execute-api.us-east-1.amazonaws.com/dev/saveUser', {
      Name: this.name,
      Mobile: this.mobile,
      Address: this.address
    }).subscribe((res: any) => {
      this.name = '';
      this.mobile = '';
      this.address = '';
      this.loadUser();
    })
  }
  loadUser() {
    this.httpclient.get('https://fzikk1yudi.execute-api.us-east-1.amazonaws.com/dev/getAllUsers').subscribe((res: any) => {
      this.listOfUser = res;
    })
  }
}
